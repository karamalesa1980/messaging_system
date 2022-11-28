module SpecUtils
  def stub_service(klass:, thing_to_return: nil, raise_exception: false)
    instance = instance_double(klass)
    allow(klass).to receive(:new).and_return(instance)

    if raise_exception
      allow(instance).to receive(:call).and_raise(thing_to_return)
    else
      allow(instance).to receive(:call).and_return(thing_to_return)
    end

    [klass, instance]
  end

  def stub_worker(klass:)
    allow(klass).to receive(:perform_async)

    klass
  end
end

RSpec.configure do |config|
  config.include SpecUtils
end
