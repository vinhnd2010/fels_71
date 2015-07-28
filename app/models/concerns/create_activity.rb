module CreateActivity
  def create_activity user_id, target_id, name
    Activity.create! user_id: user_id, target_id: target_id, name: name
  end
end
