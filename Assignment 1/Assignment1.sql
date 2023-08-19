/* REMARK 2 -- 2nd question*/

/*
Select distinct E.deptName,SM.major
FROM employedby E,studentmajor SM 
WHERE E.sid=SM.sid AND E.salary >= 20000 ORDER BY E.deptName*/


/*(Remark 2 --3rd question )*/
/*SELECT HF.sid1,HF.sid2
FROM hasfriend HF
Where (HF.sid1,HF.sid2) in (Select E1.sid,E2.sid
			From employedBy E1,employedBy E2
			where E1.deptName='CS' AND E2.deptName='CS' AND E1.sid <> E2.sid)*/

/* REMARK 2 --4th question*/

/*
Select distinct SM1.major from studentMajor SM1, studentMajor SM2 where SM1.sid <> SM2.sid AND (SM1.sid,SM2.sid) in (SELECT HF.sid1,HF.sid2
FROM hasfriend HF) */


select * from StudentMajor



