

'''
generates a list of json objects with unique names for testing purposes
objects are all identical to ranchgod object with names replaced
also takes in a filename with which to write the output file to
'''
def generate_objects(filename):
    json_objects = []
    with open("names.txt", "r") as data_file:
        lines = data_file.readlines()
        for name in lines:
            username = '"{}"'.format(name.rstrip())
            ranchgod_object = ''' : {
            "deviceID" : "fO3kKzJxME-2lOAPS7uUGO:APA91bF00nmjQI-xjNBXX85bf29lgAVfN9qK6LNRYZ9WP24ZDm9oeKHIZ-NMQXSdwXQuyRXgo37oUrEfe3Fheyx4YIsKd828MtLDC05kOPAEV0o_joqiehaLGxgAx5NJ_8Ju0Jn3GHat",
            "first_name" : "reese",
            "last_name" : "gyllenhammer",
            "relationships" : {
            "ranchgod" : "A8335020-CAC3-4D8C-BA2F-F3FED680B9C6",
            "ranchgod2" : "955BB63F-5AB8-4EFF-8B56-CE30E5269A8A"
            }
        },
        '''
            json_objects.append(username + ranchgod_object)

    with open(filename, "w") as write_file:
        write_file.writelines(json_objects)

generate_objects("testing.json")