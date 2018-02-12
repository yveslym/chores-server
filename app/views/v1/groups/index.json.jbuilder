
    json.groups @v1_group do |group|
        json.partial! 'v1/groups/group', group: group
end
