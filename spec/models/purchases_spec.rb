require 'spec_helper'

context "Purchase" do
  let (:current_user) { create(:user) }

  it "returns purchases by user" do
    purchase = create(:purchase, user: current_user)

  end

  it "returns purchases after a given date" do
  end

  it "returns a limited number of purchases" do
  end

end
