$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'require_latest'

require 'minitest/autorun'
require 'rubygems/uninstaller'

class RequireLatestTest < Minitest::Test
  def test_require_new_gem
    # no gem locally available, but remote
    assert_raises(LoadError){ require 'foo' }
    require_latest 'foo', src: "file://#{File.join(__dir__, 'test_gems')}"
    assert_equal '0.2.0', Foo::VERSION

    ensure
      begin
        Gem::Uninstaller.new('foo').uninstall
      rescue => e
      end
  end

  def test_no_gem_neither_local_nor_remote_available
    # super-duper-strange-name-which-probably-will-never-exist-as-gem-name
    # I tried foo, but that actually exists already in different versions
    assert_raises(LoadError){ require_latest 'sdsnwpwneagn' }
  end
end
