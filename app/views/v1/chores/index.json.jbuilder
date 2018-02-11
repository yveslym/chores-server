json.array! @v1_chores do |each_chore|
    json.partial! 'v1/chores/chore', chore: each_chore
end
