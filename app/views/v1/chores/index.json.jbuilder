json.data do
    json.array! @v1_chores, :id, :name, :penality, :due_date, :reward
end
