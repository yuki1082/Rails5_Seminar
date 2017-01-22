#coding: utf-8
require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  def setup
    @members = [
      FactoryGirl.create(:member, name:"xa", full_name: "x-ab", number:1),
      FactoryGirl.create(:member, name:"yy", full_name: "yy-ab",number:2),
      FactoryGirl.create(:member, name:"bb", full_name: "z-bb", number:3),
      FactoryGirl.create(:member, name:"xx", full_name: "x-ab", number:4),
    ]
  end

  test "factory girl" do
    member = FactoryGirl.create(:member, number:5)
    assert_equal "Yamada Taro", member.full_name
  end

  test "search unregisterd member" do
    members = Member.search("hoge").to_a
    assert_equal [], members
  end

  test "no results" do
    members = Member.search("hoge")
    assert_equal 0, members.length
  end

  test "seach full_name is x-ab" do
    members = Member.search("x-ab")
    assert_equal 2, members.length
    target_name = ["xa", "xx"]
    members.each_with_index do |member, idx|
      assert_equal target_name[idx] , member.name
    end
  end

  test "authenticate" do 
    member = FactoryGirl.create(:member, name: "taro", password: "happy", password_confirmation: "happy", number:6)
    assert_nil Member.authenticate("taro", "lucky")
    assert_equal member, Member.authenticate("taro", "happy")
  end 



end
