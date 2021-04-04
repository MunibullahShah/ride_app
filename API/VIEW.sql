CREATE VIEW messageTop AS SELECT messages.* from messages
JOIN
(SELECT MAX(DateSent) maxtime,Sender FROM messages GROUP BY Sender) latestS
ON messages.DateSent=latestS.maxtime AND messages.Receiver=latestS.Sender
UNION 
SELECT messages.* from messages
JOIN
(SELECT MAX(DateSent) maxtime,Receiver FROM messages GROUP BY Receiver) latestR
ON messages.DateSent=latestR.maxtime AND messages.Receiver=latestR.Receiver;