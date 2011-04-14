require 'require_relative' if RUBY_VERSION[0,3] == '1.8'
require_relative 'acceptance_helper'

class TranslationsTest < MiniTest::Unit::TestCase

  include AcceptanceHelper

  def test_translation_meta
    page.driver.reset!
    page.driver.header "Accept-Language", "en-US,en;q=0.8"
    visit "/"
    assert_match "<html class='no-js' lang='en'>", page.body
    assert_match "<meta content='en' http-equiv='Content-Language' />", page.body
    page.driver.reset!
    page.driver.header "Accept-Language", "en-US,en;q=0.8"
  end
  def test_translation_meta_other
    page.driver.reset!
    page.driver.header "Accept-Language", "ja,en-US;q=8.0,en;q=0.6"
    visit "/"
    assert_match "<html class='no-js' lang='ja'>", page.body
    assert_match "<meta content='ja' http-equiv='Content-Language' />", page.body
    page.driver.reset!
    page.driver.header "Accept-Language", "en-US,en;q=0.8"
  end

  def test_translation_language_detection
    #this might need to be updated when the front page changes
    page.driver.reset!
    page.driver.header "Accept-Language", "eo,en-US;q=0.8,en;q=0.6"
    visit "/"
    assert_match "<html class='no-js' lang='eo'>", page.body
    assert_match "<meta content='eo' http-equiv='Content-Language' />", page.body
    assert_match "Komunigu", page.body
    page.driver.reset!
    page.driver.header "Accept-Language", "en-US,en;q=0.8"
  end

end
