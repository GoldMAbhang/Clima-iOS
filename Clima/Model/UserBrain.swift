import Foundation

protocol UserBrainDelegate{
    func sendUsername(usernameSaved:String)
}

struct UserBrain{
    var newUsers = [Users]()
    
    var delegate:UserBrainDelegate?
    
    mutating func isValid(username:String,password:String)->Bool{
        //decoding here for validation of login
        if let data = UserDefaults.standard.value(forKey:"users") as? Data {
            newUsers = try! PropertyListDecoder().decode([Users].self, from: data)
            print("UserDefaultData::::::\(newUsers)")
        }
        
        //for iterating through the new array newUsers checking for new users array
        for user in 0...newUsers.count - 1{
            let newUser = newUsers[user]
            if username == newUser.username && password == newUser.password{
                return true
            }
        }
        return false
    }
    
    
    mutating func addUsers(newUsername:String,newPassword:String)->Bool{
        print(newUsers)
        //User Defaults encode and decode methods for saving data
        
        //removing all array value since it can only save one array
        newUsers.removeAll()
        
        //then encoding the previously inserted value into the userdefaults and decode for printing
        if let data = UserDefaults.standard.value(forKey:"users") as? Data {
            newUsers = try! PropertyListDecoder().decode([Users].self, from: data)
            print("UserDefaultData::::::\(newUsers)")
            
            //loop to check if username exists if not create one
            for user in 0...newUsers.count - 1{
                let savedUsername = newUsers[user]
                if newUsername != savedUsername.username{
                    print("Different Username")
                    newUsers.append(Users(username: newUsername,password: newPassword))
                    self.delegate?.sendUsername(usernameSaved: newUsername)
                    
                    
                    print(newUsers)
                    let new = UserDefaults.standard
                    new.set(try? PropertyListEncoder().encode(newUsers), forKey:"users")
                    break
                }
                else{
                    print("Username exists")
                    break
                }
            }
        }
        return true
    }
}
