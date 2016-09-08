CREATE TABLE congress_members (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(64) NOT NULL,
  party VARCHAR(64) NOT NULL,
  location VARCHAR(64) NOT NULL,
  grade_1996 REAL,
  grade_current REAL,
  years_in_congress INTEGER,
  dw1_score REAL
, created_at DATETIME, updated_at DATETIME);
CREATE TABLE voters (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(64) NOT NULL,
    last_name  VARCHAR(64) NOT NULL,
    gender VARCHAR(64) NOT NULL,
    party VARCHAR(64) NOT NULL,
    party_duration INTEGER,
    age INTEGER,
    married INTEGER,
    children_count INTEGER,
    homeowner INTEGER,
    employed INTEGER,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
  );
CREATE TABLE votes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    voter_id INTEGER,
    politician_id INTEGER,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY(voter_id) REFERENCES voters(id),
    FOREIGN KEY(politician_id) REFERENCES congress_members(id)
  );

===============================
========== RELEASE 1 ==========
===============================

1. Hitung jumlah vite untuk Sen. Olympia Snowe yang memiliki id 524.

SELECT COUNT( * )
FROM votes
WHERE politician_id = 524;

=> 22


2. Sekarang lakukan JOIN tanpa menggunakan id 524. Query kedua tabel votes dan congress_members.

SELECT *
FROM votes a
INNER JOIN congress_members b ON b.id = a.politician_id;


3. Sekarang gimana dengan representative Erik Paulsen? Berapa banyak vote yang dia dapatkan?

SELECT *
FROM votes a
INNER JOIN congress_members b ON b.id = a.politician_id
WHERE b.name LIKE '%Erik Paulsen%';


4. Buatlah daftar peserta Congress yang mendapatkan vote terbanyak. Jangan sertakan field created_at dan updated_at

SELECT b.id, b.name, b.party, b.location, b.grade_1996, b.grade_current, b.years_in_congress, b.dw1_score, COUNT( * ) votes FROM votes a
INNER JOIN congress_members b ON b.id = a.politician_id
GROUP BY b.id
ORDER BY votes DESC
LIMIT 1;

=> 224|Rep. Dan Benishek|R|MI|11.29829673|11.29829673|1|0.625|32


5. Sekarang buatlah sebuah daftar semua anggota Congress yang setidaknya mendapatkan beberapa vote dalam urutan dari yang paling sedikit. Dan juga jangan sertakan field-field yang memiliki tipe date.

SELECT b.id, b.name, b.party, b.location, b.grade_1996, b.grade_current, b.years_in_congress, b.dw1_score, COUNT( * ) votes FROM votes a
INNER JOIN congress_members b ON b.id = a.politician_id
GROUP BY b.id
ORDER BY votes ASC;


===============================
========== RELEASE 2 ==========
===============================

1. Siapa anggota Congress yang mendapatkan cote terbanyak? List nama tersebut mereka dan jumlah vote-nya. Siapa saja yang memilih politisi tersebut? List nama mereka, dan jenis kelamin mereka.

SELECT b.first_name, b.last_name, b.gender FROM votes a
inner join voters b on b.id = a.voter_id
WHERE a.politician_id in
  (SELECT b.id id FROM votes a
  INNER JOIN congress_members b ON b.id = a.politician_id
  GROUP BY b.id
  ORDER BY COUNT( * ) DESC
  LIMIT 1);


2. Berapa banyak vote yang diterima anggota Congress yang memiliki grade di bawah 9 (gunakan field grade_current)? Ambil nama, lokasi, grade_current, dan jumlah vote.

SELECT b.name, b.location, b.grade_current, COUNT( * )
FROM votes a
INNER JOIN congress_members b ON b.id = a.politician_id
WHERE b.grade_current < 9
GROUP BY b.id
ORDER BY COUNT( * ) DESC;


3. Apa saja 10 negara bagian yang memiliki voters terbanyak? List semua orang yang melakukan vote di negara bagian yang paling populer. (Akan menjadi daftar yang panjang, kamu bisa gunakan hasil dari query pertama untuk menyerdehanakan query berikut ini.)

SELECT a.first_name, a.last_name, c.location FROM voters a
INNER JOIN votes b ON b.voter_id = a.id
INNER JOIN congress_members c ON c.id = b.politician_id
WHERE c.location in
  (SELECT b.location location FROM votes a
  INNER JOIN congress_members b ON b.id = a.politician_id
  GROUP BY b.location
  ORDER BY COUNT( * ) DESC
  LIMIT 10)
ORDER BY c.location ASC;


4. List orang-orang yang vote lebih dari dua kali. Harusnya mereka hanya bisa vote untuk posisi Senator dan satu lagi untuk wakil. Wow, kita dapat si tukang cureng! Segera laporkan ke KPK!!

SELECT b.id, b.first_name, b.last_name, c.name FROM votes a
INNER JOIN voters b ON b.id = a.voter_id
INNER JOIN congress_members c ON c.id = A.politician_id
GROUP BY b.id
HAVING COUNT( * ) > 2
ORDER BY b.id ASC;

WADOW BANYAK ORANG


5. Apakah ada orang yang melakukan vote kepada politisi yang sama dua kali? Siapa namanya dan siapa nama politisnya?

SELECT DISTINCT c.id, c.name, c.location FROM votes a
INNER JOIN voters b ON b.id = a.voter_id
INNER JOIN congress_members c ON c.id = A.politician_id
GROUP BY b.id, c.id
HAVING COUNT( * ) > 1
ORDER BY c.name ASC;

DAFTAR PENJAHAT PANTAS DITANGKAP OLEH KAPEKA
=================================
66  | Rep. Andy Harris      | MD
97  | Rep. Collin Peterson  | MN
336 | Rep. Dale Kildee      | MI
178 | Rep. Dennis Ross      | FL
217 | Rep. Donna Edwards    | MD
482 | Rep. Jeff Fortenberry | NE
471 | Rep. Jim Costa        | CA
192 | Rep. Joe Baca         | CA
436 | Rep. Joe Wilson       | SC
119 | Rep. Kurt Schrader    | OR
384 | Rep. Mike McIntyre    | NC
405 | Rep. Mike Simpson     | ID
469 | Rep. Stephen Fincher  | TN
142 | Rep. Steve Scalise    | LA
480 | Rep. Todd Platts      | PA
146 | Sen. Bernie Sanders   | VT
98  | Sen. Lamar Alexander  | TN
10  | Sen. Ron Johnson      | WI
174 | Sen. Sherrod Brown    | OH
=================================
