class CreateIntervals < ActiveRecord::Migration
  def change
    create_table :intervals do |t|
      t.string :name, :null => false
      t.text :description, :null => false
      t.integer :value, :default => 0
      t.boolean :public, :default => false
      t.boolean :enabled, :default => false

      t.timestamps
    end
    Interval.create(:name => '30 secs', :description => '30 seconds tests.',
      :value => 30, :public => false, :enabled => true )
    Interval.create(:name => '1 min', :description => '1 minute tests.',
      :value => 60, :public => false, :enabled => true )
    Interval.create(:name => '3 mins',:description => '3 minutes tests.',
      :value => 180, :public => false, :enabled => true )
    Interval.create(:name => '5 mins', :description => '5 minutes tests.',
      :value => 300, :public => true, :enabled => true )
    Interval.create(:name => '10 mins', :description => '10 minutes tests.',
      :value => 600, :public => true, :enabled => true )
    Interval.create(:name => '30 mins', :description => '30 minutes tests.',
      :value => 1800, :public => true, :enabled => true )
    Interval.create(:name => '60 mins', :description => '60 minutes tests.',
      :value => 3600, :public => true, :enabled => true )
  end
end
