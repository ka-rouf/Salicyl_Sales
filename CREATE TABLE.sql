-- Create table based on the available six csv files from data sources
-- Create table 'pelanggan1'
CREATE TABLE pelanggan1 (
     id_pelanggan CHAR(9) PRIMARY KEY,
     kelas_bisnis VARCHAR(25), 
     nama_pelanggan VARCHAR(100),
     id_cabang CHAR(5),
     nama_daerah VARCHAR(50),
     id_usaha CHAR(3),
     jenis_usaha VARCHAR(25)
     );
 
 -- Create table 'pelanggan2'
 CREATE TABLE pelanggan2 (
     id_pelanggan CHAR(9) PRIMARY KEY,
     kelas_bisnis VARCHAR(25), 
     nama_pelanggan VARCHAR(100),
     id_cabang CHAR(5),
     nama_daerah VARCHAR(50),
     id_distributor VARCHAR(5),
     jenis_usaha VARCHAR(25)
 );

 -- Create table 'barang1'
 CREATE TABLE barang1 (
     id_barang CHAR(7) PRIMARY KEY,
     sektor_produk CHAR(1), 
     nama_barang VARCHAR(100),
     id_tipe CHAR(4),
     tipe_produk VARCHAR(25),
     id_kategori CHAR(3),
     kategori_produk VARCHAR(25),
     satuan_kemasan VARCHAR(25)
 );
 
 -- Create table 'barang2'
 CREATE TABLE barang2 (
     id_barang CHAR(7) PRIMARY KEY,
     nama_barang VARCHAR(100), 
     satuan_kemasan VARCHAR(25),
     harga_idr DECIMAL(10, 2),
     tipe_produk VARCHAR(25),
     id_kategori CHAR(3),
     kategori_produk VARCHAR(25)
 );
 
 -- Create table 'penjualan1'
 CREATE TABLE penjualan1 (
     id_distributor VARCHAR(5),
     id_cabang CHAR(5), 
     id_transaksi CHAR(6),
     tanggal_transaksi DATE,
     id_pelanggan CHAR(9),
     id_barang CHAR(7),
     jumlah_barang INT,
     satuan_kemasan VARCHAR(25),
     harga_idr DECIMAL(10, 2),
     id_merek CHAR(7),
     kategori_produk VARCHAR(25)
 );

 -- Create table 'penjualan2'
 CREATE TABLE penjualan2 (
     id_transaksi CHAR(6),
     tanggal_transaksi DATE, 
     id_pelanggan CHAR(9),
     id_barang CHAR(7),
     jumlah_barang INT,
     satuan_kemasan VARCHAR(25),
     harga_idr DECIMAL(10, 2)
 );