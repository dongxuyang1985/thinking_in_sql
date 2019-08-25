-- Oracle 实现
CREATE TABLE stock (scode VARCHAR(10), tradedate DATE, price NUMERIC(6,2));

ALTER SESSION SET nls_date_format = 'YYYY-MM-DD';
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-01',79);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-02',61);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-03',57);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-04',56);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-05',50);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-06',65);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-07',53);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-08',56);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-09',51);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-10',42);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-11',40);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-12',32);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-13',55);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-14',42);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-15',30);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-16',30);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-17',47);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-18',59);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-19',58);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-20',44);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-21',48);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-22',32);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-23',37);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-24',42);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-25',49);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-26',51);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-27',58);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-28',39);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-29',43);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-30',66);
INSERT INTO stock (scode,tradedate,price) VALUES ('S001','2019-01-31',61);

CREATE TABLE bank_log
( log_id    INTEGER NOT NULL PRIMARY KEY,
  ts        DATE NOT NULL,
  from_user VARCHAR(50) NOT NULL,
  amount    NUMERIC(10) NOT NULL,
  type      VARCHAR(10) NOT NULL,
  to_user   VARCHAR(50)
);

INSERT INTO bank_log VALUES (1, TO_DATE('2019-01-02 10:31:40', 'YYYY-MM-DD HH24:MI:SS'), '62221234567890', 50000, '存款', NULL);
INSERT INTO bank_log VALUES (2, TO_DATE('2019-01-02 10:32:15', 'YYYY-MM-DD HH24:MI:SS'), '62221234567890', 100000, '存款', NULL);
INSERT INTO bank_log VALUES (3, TO_DATE('2019-01-03 08:14:29', 'YYYY-MM-DD HH24:MI:SS'), '62221234567890', 200000, '转账', '62226666666666');
INSERT INTO bank_log VALUES (4, TO_DATE('2019-01-05 13:55:38', 'YYYY-MM-DD HH24:MI:SS'), '62221234567890', 150000, '转账', '62226666666666');
INSERT INTO bank_log VALUES (5, TO_DATE('2019-01-07 20:00:31', 'YYYY-MM-DD HH24:MI:SS'), '62221234567890', 300000, '转账', '62227777777777');
INSERT INTO bank_log VALUES (6, TO_DATE('2019-01-09 17:28:07', 'YYYY-MM-DD HH24:MI:SS'), '62221234567890', 500000, '转账', '62228888888888');
INSERT INTO bank_log VALUES (7, TO_DATE('2019-01-10 07:46:02', 'YYYY-MM-DD HH24:MI:SS'), '62221234567890', 100000, '转账', '62228888888888');
INSERT INTO bank_log VALUES (8, TO_DATE('2019-01-11 09:36:53', 'YYYY-MM-DD HH24:MI:SS'), '62221234567890', 40000, '存款', NULL);
INSERT INTO bank_log VALUES (9, TO_DATE('2019-01-12 07:10:01', 'YYYY-MM-DD HH24:MI:SS'), '62221234567890', 10000, '转账', '62228888888881');
INSERT INTO bank_log VALUES (10, TO_DATE('2019-01-12 07:11:12', 'YYYY-MM-DD HH24:MI:SS'), '62221234567890', 8000, '转账', '62228888888882');
INSERT INTO bank_log VALUES (11, TO_DATE('2019-01-12 07:12:36', 'YYYY-MM-DD HH24:MI:SS'), '62221234567890', 5000, '转账', '62228888888883');
INSERT INTO bank_log VALUES (12, TO_DATE('2019-01-12 07:13:55', 'YYYY-MM-DD HH24:MI:SS'), '62221234567890', 6000, '转账', '62228888888884');
INSERT INTO bank_log VALUES (13, TO_DATE('2019-01-12 07:14:24', 'YYYY-MM-DD HH24:MI:SS'), '62221234567890', 7000, '转账', '62228888888885');
INSERT INTO bank_log VALUES (14, TO_DATE('2019-01-21 12:11:16', 'YYYY-MM-DD HH24:MI:SS'), '62221234567890', 70000, '转账', '62228888888885');