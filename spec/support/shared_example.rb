shared_examples "requires sign in" do
  it "redirects to sign in paht" do
    clear_current_user
    action
    expect(response).to redirect_to sign_in_path
  end
end
