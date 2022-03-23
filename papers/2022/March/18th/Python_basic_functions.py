##Calculating the total area of a cube

length = int(input("Enter  the length of the Cube:.."))

area = 6*length*length
print(length)
print("The area of the cube is", + area)


#
#Volume of a sphere

sphere_section = 0.75
pi = 3.142
sphereRadius = int(input("Enter the radius of the square to calculate: .."))
sphereVolume = sphere_section*pi*sphereRadius
print("The volume of the sphere is", +sphereVolume)

#Geolocation calculator
import math
k1 = [6, 0]
k2 = [8, 12]
geoDistance = math.sqrt( ((k1[0]-k2[0])**2)+((k1[1]-k2[1])**2) )

print("The distance between X and Y is ", + geoDistance)

##

# Degree / Farenheit conversion
fromCelsius = int(input("Enter the degree celcius to convert to Farenheit: .."))

toFahrenheit = (fromCelsius * 1.8) + 32
print(fromCelsius,"Celcius"