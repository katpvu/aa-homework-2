#gives an object of objects
@users.each do |user|
    json.set! user.id do 
        json.extract! user, :id, :username, :created_at
    end
    json.taylor_swift "1234"
end

# ===> res
# { 1: {
#     "id": 1,
#     "username": "blaal",
#     "created_at": "218736218"
# }, 2: {
#     "id": 1,
#     "username": "blaal",
#     "created_at": "218736218"
# }, 3: {
#     "id": 1,
#     "username": "blaal",
#     "created_at": "218736218"
# }}

#gives an array of objects
json.array! @users.do |user|
    json.extract! user, :id, :username, :created_at
end

#creating several top level keys
json.user do
    json.extract! @user, :id, :username, :created_at
    json.addCustomKey "value of custom key"
end

json.anotherTopLevelKey do
    json.key "value"
end
# ====> res
# {"user": {
#     "id": 1,
#     "username": "diego",
#     "created_at": "2138761"
# },
# "anotherTopLevelKey": {
#     "key": "value"
# }