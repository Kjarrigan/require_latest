module RequireLatest
  VERSION = '0.2.4'

  require 'rubygems'
  require 'rubygems/remote_fetcher'
  require 'rubygems/name_tuple'

  def require_latest(spec_name, src: 'https://rubygems.org', require: spec_name)
    src = Gem::Source.new src
    list = src.load_specs(:latest).find_all{|spec| spec.name == spec_name }
    remote_spec = if list.size != 1
      # If there are multiple packages with the same name that usually means there are precompiled version for different
      # platforms. So check if a matching platform is available or just use the "ruby" (general) one.
      list = list.find_all{|spec| RUBY_PLATFORM =~ Regexp.new(spec.platform) }.first || list.find_all{|spec| spec.platform == 'ruby' }

      # somehow I got two "latest" version for a gem:
      # list = src.load_specs(:latest).find_all{|spec| spec.name == 'require_latest' }
      # => [#<Gem::NameTuple require_latest, 0.2.1, ruby>, #<Gem::NameTuple require_latest, 0.2.2, ruby>]
      # as I uploaded another version while an irb session with the old version was still running.
      # so add an sort to really get the latest...
      list.sort{|s1,s2| s1.version <=> s2.version }.reverse.first
    else
      list.first
    end

    local_spec = begin
      Gem::Specification.find_by_name spec_name
    rescue Gem::LoadError
      :not_installed
    end

    fail LoadError, "no gem `#{spec_name}` found locally or remotely (#{src})" if local_spec == :not_installed && remote_spec.nil?

    if local_spec == :not_installed or (remote_spec && (local_spec.version < remote_spec.version))
      Gem.install spec_name, remote_spec.version

      Gem.clear_paths
      gem spec_name, remote_spec.version
    else
      gem spec_name, local_spec.version
    end
    Kernel.require require
  end
end

include RequireLatest
