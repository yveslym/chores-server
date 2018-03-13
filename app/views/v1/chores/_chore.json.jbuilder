#This method uses a jbuilder object, then uses the .call method to return to us an object that has
# the specified parameters

json.call(
    chore,
    :id,
    :name,
    :penalty,
    :due_date,
    :reward,
    :completed,
    :assigned,
    :user_id,
    :groupname
)
