require_relative 'spec_helper'


describe Application do

  subject(:app) { Application.new(['post.html']) } 

  it "has a page variable" do
    expect(app.class).to eql Application
  end

  it "is an Application"
end