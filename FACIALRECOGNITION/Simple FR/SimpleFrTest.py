import face_recognition

#load sample image of subject
#then load image to compare with subject
known_image = face_recognition.load_image_file("biden.jpg")
unknown_image = face_recognition.load_image_file("shawnloo.jpg")

#convert sample and comparision image to endcodings to allow for comparision
biden_encoding = face_recognition.face_encodings(known_image)[0]
unknown_encoding = face_recognition.face_encodings(unknown_image)[0]

#tolerence is how strict
#lower the strictere
#current sweet spot = 0.4
results = face_recognition.compare_faces([biden_encoding], unknown_encoding,tolerance=0.4) 

#true = match
#false = not match
print(results)