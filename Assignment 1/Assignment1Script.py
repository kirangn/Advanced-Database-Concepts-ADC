-- Python data for schemas and instances for assignment 1


# Student(sid: integer, sname: text, homeCity: text)

Student = [
 {'sid' : 1001, 'sname' : 'Jean', 'homeCity' : 'Cupertino'},
 {'sid' : 1002, 'sname' : 'Vidya', 'homeCity' : 'Cupertino'},
 {'sid' : 1003, 'sname' : 'Anna', 'homeCity' : 'Seattle'},
 {'sid' : 1004, 'sname' : 'Qin', 'homeCity' : 'Seattle'},
 {'sid' : 1005, 'sname' : 'Megan', 'homeCity' : 'MountainView'},
 {'sid' : 1006, 'sname' : 'Ryan', 'homeCity' : 'Chicago'},
 {'sid' : 1007, 'sname' : 'Danielle', 'homeCity' : 'LosGatos'},
 {'sid' : 1008, 'sname' : 'Emma', 'homeCity' : 'Bloomington'},
 {'sid' : 1009, 'sname' : 'Hasan', 'homeCity' : 'Bloomington'},
 {'sid' : 1010, 'sname' : 'Linda', 'homeCity' : 'Chicago'},
 {'sid' : 1011, 'sname' : 'Nick', 'homeCity' : 'MountainView'},
 {'sid' : 1012, 'sname' : 'Eric', 'homeCity' : 'Cupertino'},
 {'sid' : 1013, 'sname' : 'Lisa', 'homeCity' : 'Indianapolis'},
 {'sid' : 1014, 'sname' : 'Deepa', 'homeCity' : 'Bloomington'},
 {'sid' : 1015, 'sname' : 'Chris', 'homeCity' : 'Denver'},
 {'sid' : 1016, 'sname' : 'YinYue', 'homeCity' : 'Chicago'},
 {'sid' : 1017, 'sname' : 'Latha', 'homeCity' : 'LosGatos'},
 {'sid' : 1018, 'sname' : 'Arif', 'homeCity' : 'Bloomington'},
 {'sid' : 1019, 'sname' : 'John', 'homeCity' : 'NewYork'}]


# Department(deptName: text, mainOffice: text)

Department = [
 {'deptName' : 'CS', 'mainOffice' : 'LuddyHall'},
 {'deptName' : 'DataScience', 'mainOffice' : 'LuddyHall'},
 {'deptName' : 'Mathematics', 'mainOffice' : 'RawlesHall'},
 {'deptName' : 'Physics', 'mainOffice' : 'SwainHall'},
 {'deptName' : 'Biology', 'mainOffice' : 'JordanHall'},
 {'deptName' : 'Chemistry', 'mainOffice' : 'ChemistryBuilding'},
 {'deptName' : 'Astronomy', 'mainOffice' : 'SwainHall'}]



# Major(major: text)

Major = [
 {'major' : 'CS'},
 {'major' : 'DataScience'},
 {'major' : 'Physics'},
 {'major' : 'Chemistry'},
 {'major' : 'Biology'}
]    


# employedBy(sid: integer,deptName:text,salary:integer)

employedBy = [ {'sid' : 1001, 'deptName' : 'CS', 'salary' : 65000},
 {'sid' : 1002, 'deptName' : 'CS', 'salary' : 45000},
 {'sid' : 1003, 'deptName' : 'DataScience', 'salary' : 55000},
 {'sid' : 1004, 'deptName' : 'DataScience', 'salary' : 55000},
 {'sid' : 1005, 'deptName' : 'Mathematics', 'salary' : 60000},
 {'sid' : 1006, 'deptName' : 'DataScience', 'salary' : 55000},
 {'sid' : 1007, 'deptName' : 'Physics', 'salary' : 50000},
 {'sid' : 1008, 'deptName' : 'DataScience', 'salary' : 50000},
 {'sid' : 1009, 'deptName' : 'CS', 'salary' : 60000},
 {'sid' : 1010, 'deptName' : 'DataScience', 'salary' : 55000},
 {'sid' : 1011, 'deptName' : 'Mathematics', 'salary' : 70000},
 {'sid' : 1012, 'deptName' : 'CS', 'salary' : 50000},
 {'sid' : 1013, 'deptName' : 'Physics', 'salary' : 55000},
 {'sid' : 1014, 'deptName' : 'CS', 'salary' : 50000},
 {'sid' : 1015, 'deptName' : 'DataScience', 'salary' : 60000},
 {'sid' : 1016, 'deptName' : 'DataScience', 'salary' : 55000},
 {'sid' : 1017, 'deptName' : 'Physics', 'salary' : 60000},
 {'sid' : 1018, 'deptName' : 'CS', 'salary' : 50000},
 {'sid' : 1019, 'deptName' : 'Biology', 'salary' : 50000}
]

# departmentLocation(deptName:text, building:text)

departmentLocation = [
 {'deptName' : 'CS', 'building' : 'LindleyHall'},
 {'deptName' : 'DataScience', 'building' : 'LuddyHall'},
 {'deptName' : 'DataScience', 'building' : 'Kinsey'},
 {'deptName' : 'DataScience', 'building' : 'WellsLibrary'},
 {'deptName' : 'Mathematics', 'building' : 'RawlesHall'},
 {'deptName' : 'Physics', 'building' : 'SwainHall'},
 {'deptName' : 'Physics', 'building' : 'ChemistryBuilding'},
 {'deptName' : 'Biology', 'building' : 'JordanHall'},
 {'deptName' : 'CS', 'building' : 'LuddyHall'},
 {'deptName' : 'Mathematics', 'building' : 'SwainHall'},
 {'deptName' : 'Physics', 'building' : 'RawlesHall'},
 {'deptName' : 'Biology', 'building' : 'MultiDisciplinaryBuilding'},
 {'deptName' : 'Chemistry', 'building' : 'ChemistryBuilding'}]



# studentMajor(sid:integer, major:text)

studentMajor = [
 {'sid' : 1001, 'major' : 'CS'},
 {'sid' : 1001, 'major' : 'DataScience'},
 {'sid' : 1002, 'major' : 'CS'},
 {'sid' : 1002, 'major' : 'DataScience'},
 {'sid' : 1004, 'major' : 'DataScience'},
 {'sid' : 1004, 'major' : 'CS'},
 {'sid' : 1005, 'major' : 'DataScience'},
 {'sid' : 1005, 'major' : 'CS'},
 {'sid' : 1005, 'major' : 'Physics'},
 {'sid' : 1006, 'major' : 'CS'},
 {'sid' : 1006, 'major' : 'Chemistry'},
 {'sid' : 1007, 'major' : 'Chemistry'},
 {'sid' : 1007, 'major' : 'CS'},
 {'sid' : 1009, 'major' : 'Chemistry'},
 {'sid' : 1009, 'major' : 'Physics'},
 {'sid' : 1010, 'major' : 'Physics'},
 {'sid' : 1011, 'major' : 'Physics'},
 {'sid' : 1011, 'major' : 'Chemistry'},
 {'sid' : 1011, 'major' : 'DataScience'},
 {'sid' : 1011, 'major' : 'CS'},
 {'sid' : 1012, 'major' : 'DataScience'},
 {'sid' : 1012, 'major' : 'Chemistry'},
 {'sid' : 1012, 'major' : 'CS'},
 {'sid' : 1013, 'major' : 'CS'},
 {'sid' : 1013, 'major' : 'DataScience'},
 {'sid' : 1013, 'major' : 'Chemistry'},
 {'sid' : 1013, 'major' : 'Physics'},
 {'sid' : 1014, 'major' : 'Chemistry'},
 {'sid' : 1014, 'major' : 'DataScience'},
 {'sid' : 1014, 'major' : 'Physics'},
 {'sid' : 1015, 'major' : 'CS'},
 {'sid' : 1015, 'major' : 'DataScience'},
 {'sid' : 1016, 'major' : 'Chemistry'},
 {'sid' : 1016, 'major' : 'DataScience'},
 {'sid' : 1017, 'major' : 'Physics'},
 {'sid' : 1017, 'major' : 'CS'},
 {'sid' : 1018, 'major' : 'DataScience'},
 {'sid' : 1019, 'major' : 'Physics'}
]


# hasFriend(sid1:integer, sid2:integer)

hasFriend = [
 {'sid1' : 1001, 'sid2' : 1008},
 {'sid1' : 1001, 'sid2' : 1012},
 {'sid1' : 1001, 'sid2' : 1014},
 {'sid1' : 1001, 'sid2' : 1019},
 {'sid1' : 1002, 'sid2' : 1001},
 {'sid1' : 1002, 'sid2' : 1002},
 {'sid1' : 1002, 'sid2' : 1011},
 {'sid1' : 1002, 'sid2' : 1014},
 {'sid1' : 1002, 'sid2' : 1015},
 {'sid1' : 1003, 'sid2' : 1004},
 {'sid1' : 1004, 'sid2' : 1002},
 {'sid1' : 1004, 'sid2' : 1003},
 {'sid1' : 1004, 'sid2' : 1012},
 {'sid1' : 1004, 'sid2' : 1013},
 {'sid1' : 1004, 'sid2' : 1014},
 {'sid1' : 1004, 'sid2' : 1019},
 {'sid1' : 1005, 'sid2' : 1015},
 {'sid1' : 1006, 'sid2' : 1003},
 {'sid1' : 1006, 'sid2' : 1004},
 {'sid1' : 1006, 'sid2' : 1006},
 {'sid1' : 1007, 'sid2' : 1008},
 {'sid1' : 1007, 'sid2' : 1013},
 {'sid1' : 1007, 'sid2' : 1016},
 {'sid1' : 1007, 'sid2' : 1017},
 {'sid1' : 1008, 'sid2' : 1001},
 {'sid1' : 1008, 'sid2' : 1007},
 {'sid1' : 1008, 'sid2' : 1015},
 {'sid1' : 1008, 'sid2' : 1019},
 {'sid1' : 1009, 'sid2' : 1001},
 {'sid1' : 1009, 'sid2' : 1005},
 {'sid1' : 1009, 'sid2' : 1013},
 {'sid1' : 1010, 'sid2' : 1008},
 {'sid1' : 1010, 'sid2' : 1013},
 {'sid1' : 1010, 'sid2' : 1014},
 {'sid1' : 1011, 'sid2' : 1005},
 {'sid1' : 1011, 'sid2' : 1009},
 {'sid1' : 1011, 'sid2' : 1010},
 {'sid1' : 1011, 'sid2' : 1011},
 {'sid1' : 1012, 'sid2' : 1011},
 {'sid1' : 1013, 'sid2' : 1002},
 {'sid1' : 1013, 'sid2' : 1007},
 {'sid1' : 1013, 'sid2' : 1018},
 {'sid1' : 1014, 'sid2' : 1005},
 {'sid1' : 1014, 'sid2' : 1006},
 {'sid1' : 1014, 'sid2' : 1012},
 {'sid1' : 1014, 'sid2' : 1017},
 {'sid1' : 1015, 'sid2' : 1002},
 {'sid1' : 1015, 'sid2' : 1003},
 {'sid1' : 1015, 'sid2' : 1005},
 {'sid1' : 1015, 'sid2' : 1011},
 {'sid1' : 1015, 'sid2' : 1015},
 {'sid1' : 1015, 'sid2' : 1018},
 {'sid1' : 1016, 'sid2' : 1004},
 {'sid1' : 1016, 'sid2' : 1006},
 {'sid1' : 1016, 'sid2' : 1015},
 {'sid1' : 1017, 'sid2' : 1013},
 {'sid1' : 1017, 'sid2' : 1014},
 {'sid1' : 1017, 'sid2' : 1019},
 {'sid1' : 1018, 'sid2' : 1004},
 {'sid1' : 1018, 'sid2' : 1007},
 {'sid1' : 1018, 'sid2' : 1009},
 {'sid1' : 1018, 'sid2' : 1010},
 {'sid1' : 1018, 'sid2' : 1013},
 {'sid1' : 1019, 'sid2' : 1001},
 {'sid1' : 1019, 'sid2' : 1006},
 {'sid1' : 1019, 'sid2' : 1008},
 {'sid1' : 1019, 'sid2' : 1013}
]

# You can use the following Python functions

def print_Answer(L):  print("\n".join((str(x) for x in L)))  ## function to print elements of list one line at a time

def exists(L): return L != []

def ifThen(P,Q): return not P or Q

def student(sid, sname, homeCity): return {'sid':sid, 'sname': sname, 'homeCity': homeCity} in Student

def department(deptName, mainOffice): return {'deptName':deptName, 'mainOffice': mainOffice} in Department

def major(major): return {'major':major} in Major

def employedby(sid, deptName, salary): return {'sid':sid, 'deptName': deptName, 'salary': salary} in employedBy

def departmentlocation(deptName, building): return {'deptName':deptName, 'building': building} in departmentLocation

def studentmajor(sid,major): return {'sid':sid,'major':major} in studentMajor

def hasfriend(sid1,sid2): return {'sid1':sid1,'sid2':sid2} in hasFriend


# Problem 2
# Find each pair (d, m) where d is the name of a department and m is a
# major of a student who is employed by that department and who earns a
# salary of at least 20000.



# 'Problem 3'
# Find each pair (s1,s2) of sids of different students who have the same
# (set of) friends who work for the CS department.


# 'Problem 4'
# Find each major for which there exists a student with that major and
# who does not only have friends who also have that major.




# 'Problem 13'


# 'Problem 14'


# 'Problem 22.c'
# Some major has fewer than 2 students with that major.



# 'Problem 23.b'
# Each student who works for a department has a friend who also works
# for that department and who earns the same salary



# 'Problem 24.b'
# All students working in a same department share a major and earn the
# same salary.




