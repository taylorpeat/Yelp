require 'rails_helper'

describe Tag, type: :model do
  it { should have_many(:businesses).through(:businesses_tags) }
end