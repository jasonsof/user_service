require 'rails_helper'

RSpec.describe UserSession, type: :model do
  it { should belong_to(:user) }
end
