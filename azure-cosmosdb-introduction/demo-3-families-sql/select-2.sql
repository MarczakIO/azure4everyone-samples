SELECT c.givenName 
FROM Families f 
JOIN c IN f.children 
WHERE f.id = 'WakefieldFamily'