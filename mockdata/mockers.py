# Recommendation
import random
s = ""
for i in range(500):
    s += "INSERT INTO Recommendation VALUES ((SELECT UID FROM User where UID={}), (SELECT PID FROM Product WHERE PID ={}), {})".format(random.randint(250, 500), random.randint(250,500), random.random())
    s += ";\n"
with open('recommendation.sql', 'w') as ofile: ofile.write(s)

# Invoice
import random
s = ""
for i in range(1, 800):
    s += "INSERT INTO Invoice VALUES (" \
         "{}, (SELECT UID FROM User WHERE UID={}))".format(i, random.randint(250,700))
    s += ";\n"
with open('invoice.sql', 'w') as ofile: ofile.write(s)


# Order
import random
s = ""
for i in range(500):
    s += "INSERT INTO `Order` VALUES (" \
         "(SELECT IID FROM Invoice where IID={}), " \
         "(SELECT PID FROM Product WHERE PID ={}), {})".format(random.randint(250, 500),
                                                               random.randint(250,500),
                                                               random.randint(0,20))
    s += ";\n"
with open('order.sql', 'w') as ofile: ofile.write(s)

