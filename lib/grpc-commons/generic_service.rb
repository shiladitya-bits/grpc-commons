require 'stoplight'
require 'statsd-instrument'

module GrpcCommons

  # This is a helper for the client side gRPC call
  # Your generated proto files should be using this Service class instead of GRPC::GenericService
  # This provides basic utilities such as
  # 1. circuit breaker using **Stoplight**,
  # 2. instrumentation through **StatsD**
  # Remember to set ENV['GRPC_COMMONS_COOLOFF_INTERVAL'] = <cool-off interval to retry service call when circuit is red>
  # ===== How to use =======
  # Inherit this module in your RPC service class definition file => X_services_pb.rb
  # Replace `GRPC::GenericService` with `GrpcCommons::GenericService`
  # ========================
  module GenericService

    def self.included klass

      klass.class_eval do
        include GRPC::GenericService

        # This is an override for the same method in GRPC::GenericService
        def self.rpc_stub_class
          stub_claz = super
          instance_meths = stub_claz.instance_methods(false)
          alt_stub_claz = Class.new(stub_claz) do
            instance_meths.each do |meth|
              define_method(meth) do |*args|
                tracker_name = "#{self.class.name[0..self.class.name.rindex("::")]}:#{meth}"

                stoplight_lambda = Stoplight(tracker_name) {
                  super(*args)
                }.with_cool_off_time(ENV['GRPC_COMMONS_COOLOFF_INTERVAL'].to_i)

                response = StatsD.measure(tracker_name) do
                  stoplight_lambda.run
                end
                response

              end
            end
          end
          alt_stub_claz
        end
      end
    end

  end
end
