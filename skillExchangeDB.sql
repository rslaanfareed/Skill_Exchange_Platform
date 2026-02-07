-- =========================
-- TABLES
-- =========================

CREATE TABLE users (
  user_id NUMBER PRIMARY KEY,
  name VARCHAR2(50),
  department VARCHAR2(30),
  semester NUMBER,
  email VARCHAR2(100) UNIQUE
);

CREATE TABLE skills (
  skill_id NUMBER PRIMARY KEY,
  skill_name VARCHAR2(50),
  category VARCHAR2(30)
);

CREATE TABLE offers (
  offer_id NUMBER PRIMARY KEY,
  user_id NUMBER,
  skill_id NUMBER,
  level VARCHAR2(20),
  availability VARCHAR2(50),
  CONSTRAINT fk_offer_user FOREIGN KEY (user_id) REFERENCES users(user_id),
  CONSTRAINT fk_offer_skill FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

CREATE TABLE requests (
  request_id NUMBER PRIMARY KEY,
  user_id NUMBER,
  skill_id NUMBER,
  urgency VARCHAR2(20),
  status VARCHAR2(20),
  CONSTRAINT fk_request_user FOREIGN KEY (user_id) REFERENCES users(user_id),
  CONSTRAINT fk_request_skill FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

CREATE TABLE sessions (
  session_id NUMBER PRIMARY KEY,
  offer_id NUMBER,
  request_id NUMBER,
  session_date DATE,
  feedback_score NUMBER,
  CONSTRAINT fk_session_offer FOREIGN KEY (offer_id) REFERENCES offers(offer_id),
  CONSTRAINT fk_session_request FOREIGN KEY (request_id) REFERENCES requests(request_id)
);

-- =========================
-- SEQUENCES
-- =========================

CREATE SEQUENCE user_seq START WITH 1;
CREATE SEQUENCE skill_seq START WITH 1;
CREATE SEQUENCE offer_seq START WITH 1;
CREATE SEQUENCE request_seq START WITH 1;
CREATE SEQUENCE session_seq START WITH 1;

-- =========================
-- USERS (10)
-- =========================

INSERT INTO users VALUES (user_seq.NEXTVAL,'Ali','SE',3,'1@students.uettaxila.edu.pk');
INSERT INTO users VALUES (user_seq.NEXTVAL,'Sara','CS',4,'2@students.uettaxila.edu.pk');
INSERT INTO users VALUES (user_seq.NEXTVAL,'Ahmed','EE',2,'3@students.uettaxila.edu.pk');
INSERT INTO users VALUES (user_seq.NEXTVAL,'Usman','SE',5,'4@students.uettaxila.edu.pk');
INSERT INTO users VALUES (user_seq.NEXTVAL,'Hamza','CS',6,'5@students.uettaxila.edu.pk');
INSERT INTO users VALUES (user_seq.NEXTVAL,'Ayesha','SE',1,'6@students.uettaxila.edu.pk');
INSERT INTO users VALUES (user_seq.NEXTVAL,'Hassan','ME',4,'7@students.uettaxila.edu.pk');
INSERT INTO users VALUES (user_seq.NEXTVAL,'Zain','EE',3,'8@students.uettaxila.edu.pk');
INSERT INTO users VALUES (user_seq.NEXTVAL,'Noor','CS',2,'9@students.uettaxila.edu.pk');
INSERT INTO users VALUES (user_seq.NEXTVAL,'Bilal','SE',7,'10@students.uettaxila.edu.pk');

-- =========================
-- SKILLS (10)
-- =========================

INSERT INTO skills VALUES (skill_seq.NEXTVAL,'Python','Programming');
INSERT INTO skills VALUES (skill_seq.NEXTVAL,'Java','Programming');
INSERT INTO skills VALUES (skill_seq.NEXTVAL,'SQL','Database');
INSERT INTO skills VALUES (skill_seq.NEXTVAL,'Graphic Design','Design');
INSERT INTO skills VALUES (skill_seq.NEXTVAL,'Web Dev','Programming');
INSERT INTO skills VALUES (skill_seq.NEXTVAL,'Calculus','Academics');
INSERT INTO skills VALUES (skill_seq.NEXTVAL,'Linear Algebra','Academics');
INSERT INTO skills VALUES (skill_seq.NEXTVAL,'Data Structures','CS');
INSERT INTO skills VALUES (skill_seq.NEXTVAL,'UI/UX','Design');
INSERT INTO skills VALUES (skill_seq.NEXTVAL,'Machine Learning','AI');

-- =========================
-- OFFERS (10)
-- =========================

INSERT INTO offers VALUES (offer_seq.NEXTVAL,1,1,'Intermediate','Weekends');
INSERT INTO offers VALUES (offer_seq.NEXTVAL,2,4,'Advanced','Evenings');
INSERT INTO offers VALUES (offer_seq.NEXTVAL,3,6,'Beginner','Weekdays');
INSERT INTO offers VALUES (offer_seq.NEXTVAL,4,2,'Advanced','Weekends');
INSERT INTO offers VALUES (offer_seq.NEXTVAL,5,5,'Intermediate','Evenings');
INSERT INTO offers VALUES (offer_seq.NEXTVAL,6,3,'Beginner','Weekdays');
INSERT INTO offers VALUES (offer_seq.NEXTVAL,7,7,'Advanced','Weekends');
INSERT INTO offers VALUES (offer_seq.NEXTVAL,8,8,'Intermediate','Evenings');
INSERT INTO offers VALUES (offer_seq.NEXTVAL,9,9,'Beginner','Weekdays');
INSERT INTO offers VALUES (offer_seq.NEXTVAL,10,10,'Advanced','Flexible');

-- =========================
-- REQUESTS (10)
-- =========================

INSERT INTO requests VALUES (request_seq.NEXTVAL,3,1,'High','Open');
INSERT INTO requests VALUES (request_seq.NEXTVAL,1,4,'Medium','Open');
INSERT INTO requests VALUES (request_seq.NEXTVAL,2,6,'Low','Matched');
INSERT INTO requests VALUES (request_seq.NEXTVAL,5,2,'High','Open');
INSERT INTO requests VALUES (request_seq.NEXTVAL,6,3,'Medium','Open');
INSERT INTO requests VALUES (request_seq.NEXTVAL,7,5,'Low','Open');
INSERT INTO requests VALUES (request_seq.NEXTVAL,8,7,'High','Matched');
INSERT INTO requests VALUES (request_seq.NEXTVAL,9,8,'Medium','Open');
INSERT INTO requests VALUES (request_seq.NEXTVAL,10,9,'Low','Open');
INSERT INTO requests VALUES (request_seq.NEXTVAL,4,10,'High','Open');

-- =========================
-- SESSIONS
-- =========================

INSERT INTO sessions VALUES (session_seq.NEXTVAL,1,1,DATE '2026-02-01',5);
INSERT INTO sessions VALUES (session_seq.NEXTVAL,2,2,DATE '2026-02-05',4);
INSERT INTO sessions VALUES (session_seq.NEXTVAL,4,3,DATE '2026-02-10',5);

COMMIT;

-- =========================
-- QUERIES
-- =========================

SELECT * FROM users;
SELECT * FROM skills;
SELECT * FROM offers;
SELECT * FROM requests;
SELECT * FROM sessions;

SELECT u.name, s.skill_name, o.level
FROM offers o
JOIN users u ON o.user_id = u.user_id
JOIN skills s ON o.skill_id = s.skill_id;

SELECT u.name, s.skill_name, r.urgency
FROM requests r
JOIN users u ON r.user_id = u.user_id
JOIN skills s ON r.skill_id = s.skill_id;

SELECT 
  u1.name AS offered_by,
  u2.name AS requested_by,
  s.skill_name,
  ses.session_date,
  ses.feedback_score
FROM sessions ses
JOIN offers o ON ses.offer_id = o.offer_id
JOIN requests r ON ses.request_id = r.request_id
JOIN users u1 ON o.user_id = u1.user_id
JOIN users u2 ON r.user_id = u2.user_id
JOIN skills s ON o.skill_id = s.skill_id;
