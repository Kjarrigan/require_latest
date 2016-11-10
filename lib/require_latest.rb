module RequireLatest
  VERSION = '0.2.1'

  require 'rubygems'
  require 'rubygems/remote_fetcher'
  require 'rubygems/name_tuple'

  def require_latest(spec_name, src: 'https://rubygems.org')
    src = Gem::Source.new src
    list = src.load_specs(:latest).find_all{|spec| spec.name == spec_name }
    remote_spec = if list.size != 1
      # If there are multiple packages with the same name that usually means there are precompiled version for different
      # platforms. So check if a matching platform is available or just use the "ruby" (general) one.
      list.find_all{|spec| RUBY_PLATFORM =~ Regexp.new(spec.platform) }.first || list.find_all{|spec| spec.platform == 'ruby' }.first
    else
      list.first
    end

    local_spec = begin
      Gem::Specification.find_by_name spec_name
    rescue Gem::LoadError
      :not_installed
    end


    if local_spec == :not_installed or (local_spec.version < remote_spec.version)
      Gem.install spec_name, remote_spec.version

      Gem.clear_paths
      gem spec_name, remote_spec.version
    else
      gem spec_name, local_spec.version
    end
    require spec_name
  end
end

include RequireLatest
