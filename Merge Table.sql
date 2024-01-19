-- Merge tables 'barang1' and 'barang2'
CREATE TABLE barang AS (
SELECT br1.id_barang, br1.nama_barang, br1.satuan_kemasan, br2.harga_idr, br1.tipe_produk, br1.kategori_produk
FROM barang1 AS br1
JOIN barang2 AS br2           
ON br1.id_barang = br2.id_barang
);
-- Note: For the column 'satuan_kemasan', I chose the column from 'barang1' instead of 'barang2' because it is more trusted.
-- The reason is, products with 'KAPSUL' in their name are categorized as 'KAPSUL' in table 'barang1'. However, in table 'barang2', 
-- they are categorized as 'TABLET'. Therefore, I choose the values from the table 'barang1' for this matter.


-- Merge tables 'pelanggan1' and 'pelanggan2'
CREATE TABLE pelanggan AS (
SELECT pl1.id_pelanggan, pl1.nama_pelanggan, pl1.id_cabang, pl1.nama_daerah, pl1.jenis_usaha , pl2.id_distributor
FROM pelanggan1 AS pl1
JOIN pelanggan2 AS pl2 
ON pl1.id_pelanggan = pl2.id_pelanggan
);

## Before merging tables 'penjualan1' and 'penjualan2',
## Let's correct the data inside the table 'penjualan1' based on the data from the dimension table 'barang2'.
## The available data in the table 'penjualan1' column 'satuan_kemasan' is incorrect because all values are in 'DUS'.
## The available data in the table 'penjualan1' column 'harga_idr' also seems suspicious because it does not match the data from the dimension table.
## Even though I don't know which one is true,
## let's assume the scenario where the correct values are available in the dimesion table 'barang', and
## we need to correct the data inside the table 'penjualan1'.

-- Remove all values inside columns 'satuan_kemasan' and 'harga_idr' by 
-- changing all values in columns 'satuan_kemasan' and 'harga_idr' to NULL.
UPDATE penjualan1 SET satuan_kemasan = NULL, harga_idr = NULL;

-- Update the NULL values by referencing the values from the dimension table 'barang'.
UPDATE penjualan1 AS pj1
JOIN barang AS br ON pj1.id_barang = br.id_barang
SET pj1.satuan_kemasan = br.satuan_kemasan, pj1.harga_idr = br.harga_idr
WHERE pj1.satuan_kemasan IS NULL OR pj1.harga_idr IS NULL;

## After reviewing the current records, I noticed another inconsistency in the table.
## There are cases where a few or some records in columns 'id_merek' and 'kategori_produk' are not consistently attached to the 'id_barang' column.
## Since the previous process used the 'id_barang' column as the reference, let's continue with that scenario.

-- Change all values in columns 'id_merek' and 'kategori_produk' to NULL.
UPDATE penjualan1 SET id_merek = NULL, kategori_produk = NULL;

-- Update the NULL values in column 'kategori_produk' by referencing the values from the dimension table 'barang'
UPDATE penjualan1 AS pj1
JOIN barang AS br ON pj1.id_barang = br.id_barang
SET pj1.kategori_produk = br.kategori_produk
WHERE pj1.kategori_produk IS NULL;

-- Update the column 'id_merek ' based on values in the column 'id_barang'
UPDATE penjualan1
SET id_merek = CONCAT('BRND', RIGHT(id_barang, 3))
WHERE id_barang IS NOT NULL AND id_merek IS NULL;

## Once again, I have observed inconsistencies in the table 'penjualan1'.
## Numerous records in the 'id_distributor' and 'id_cabang' columns do not match their corresponding values in the dimension table 'pelanggan'.
## For instance, in the table 'pelanggan', 'id_pelanggan = CUST55381' has 'id_cabang = CAB02' and 'id_distributor = TA'.
## However, in the table 'penjualan1', 'id_pelanggan = CUST55381' has 'id_cabang = CAB01' and 'id_distributor = TD'.
## We need to correct the values inside these columns.

-- Change all values in the 'id_distributor' and 'id_cabang' columns to NULL
UPDATE penjualan1 SET id_distributor = NULL, id_cabang = NULL;

-- Update the 'id_distributor' and 'id_cabang' columns using the table 'pelanggan' as the reference.
UPDATE penjualan1 AS pj1
JOIN pelanggan AS pl ON pj1.id_pelanggan = pl.id_pelanggan
SET pj1.id_distributor = pl.id_distributor, pj1.id_cabang = pl.id_cabang
WHERE pj1.id_distributor IS NULL OR pj1.id_cabang IS NULL;

## After cleaning every column in the table 'penjualan1', it's time to move on to the table 'penjualan2'.
## Utilize the same reference data source as the 'penjualan1' table, which is the 'barang' table, to ensure data consistency.

-- Remove all values inside the 'satuan_kemasan' and 'harga_idr' columns by 
-- changing all values in the 'satuan_kemasan' and 'harga_idr' columns to NULL
UPDATE penjualan2 SET satuan_kemasan = NULL, harga_idr = NULL;

-- Update the NULL values by referencing the values from the dimension table 'barang'
UPDATE penjualan2 AS pj2
JOIN barang AS br ON pj2.id_barang = br.id_barang
SET pj2.satuan_kemasan = br.satuan_kemasan, pj2.harga_idr = br.harga_idr
WHERE pj2.satuan_kemasan IS NULL OR pj2.harga_idr IS NULL;

## One more step before merging table 'penjualan1' with table 'penjualan2' using UNION. We need to add columns to the table 'penjualan2', 
## so that its structure matches with table 'penjualan1'.
-- Add four empty columns to match the structure of the table 'penjualan1'
ALTER TABLE penjualan2
ADD COLUMN id_distributor VARCHAR(5),
ADD COLUMN id_cabang CHAR(5),
ADD COLUMN id_merek CHAR(7),
ADD COLUMN kategori_produk VARCHAR (25); 

-- Update the NULL values in the column 'kategori_produk' by referencing the values from the dimension table 'barang'
UPDATE penjualan2 AS pj2
JOIN barang AS br ON pj2.id_barang = br.id_barang
SET pj2.kategori_produk = br.kategori_produk
WHERE pj2.kategori_produk IS NULL;

-- Update the NULL values in the columns 'id_distributor' and 'id_cabang' by referencing the values from the dimension table 'pelanggan'.
UPDATE penjualan2 AS pj2
JOIN pelanggan AS pl ON pj2.id_pelanggan = pl.id_pelanggan
SET pj2.id_distributor = pl.id_distributor, pj2.id_cabang = pl.id_cabang
WHERE pj2.id_distributor IS NULL OR pj2.id_cabang IS NULL;

-- Update the NULL values in the column 'id_merek' by referencing the values from the table 'penjualan1'
-- (For this operation, no reference to the dimension table is needed as data about 'id_merek' is only available in the table 'penjualan1').
UPDATE penjualan2 AS pj2
JOIN penjualan1 AS pj1 ON pj2.id_barang = pj1.id_barang
SET pj2.id_merek = pj1.id_merek
WHERE pj2.id_merek IS NULL;

-- Create a new table with the columns reordered to match the structure of table 'penjualan1'
CREATE TABLE penjualan2_v2 AS
SELECT
    id_distributor,
    id_cabang,
    id_transaksi,
    tanggal_transaksi,
    id_pelanggan,
    id_barang,
    jumlah_barang,
    satuan_kemasan,
    harga_idr,
    id_merek,
    kategori_produk
FROM penjualan2;

-- Drop the original table
DROP TABLE penjualan2;

-- Rename the new table to the original table name
ALTER TABLE penjualan2_v2 RENAME TO penjualan2;

-- Merge tables 'penjualan1' and 'penjualan2'
CREATE TABLE penjualan AS
SELECT * FROM penjualan1
UNION
SELECT * FROM penjualan2;