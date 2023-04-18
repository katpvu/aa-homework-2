#json.___ without ! = creates custom key
json.user do
    json.extract! @user, :id, :username, :created_at
end

#This gets sent back to the frontend
# user: {
    #id: 1
    #username: "Diego"
    #created_at: "1245678"
#}

