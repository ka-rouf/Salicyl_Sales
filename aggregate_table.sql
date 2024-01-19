## In the Data Analysis Phases, it is essential to focus on the problems that need to be solved or business objectives.
## Hence, in this section, we only need to concentrate on Salicyl data because the goal is to build a Salicyl Sales Dashboard.
## Building a general aggregate table that includes all brands is not really necessary for now. However, to prepare for another scenario
## where stakeholders might need it in the future, we will provide it later, just in case.

## Scenario 1
-- Aggregate table 'agg_penjualan_salicyl' based on table 'basis_data_penjualan'
CREATE TABLE agg_penjualan_salicyl AS (
  SELECT 
    id_transaksi, tanggal_transaksi, WEEK(tanggal_transaksi) AS minggu_ke, MONTHNAME(tanggal_transaksi) AS bulan_ke, nama_pelanggan, 
    nama_daerah, jenis_usaha, id_distributor, nama_barang, kategori_produk, satuan_kemasan AS kemasan, jumlah_barang,
    harga_idr, jumlah_barang * harga_idr AS pendapatan
  FROM basis_data_penjualan
  WHERE kategori_produk = 'SLCYL'
);
-- Aggregate table 'agg_semua_penjualan' based on table 'basis_data_penjualan'
CREATE TABLE agg_semua_penjualan AS (
  SELECT 
    id_transaksi, tanggal_transaksi, WEEK(tanggal_transaksi) AS minggu_ke, MONTHNAME(tanggal_transaksi) AS bulan_ke, nama_pelanggan, 
    nama_daerah, jenis_usaha, id_distributor, nama_barang, kategori_produk, satuan_kemasan AS kemasan, jumlah_barang,
    harga_idr, jumlah_barang * harga_idr AS pendapatan
  FROM basis_data_penjualan
);

## Scenario 2
-- Aggregate table 'agg_penjualan_salicyl_v2' based on table 'basis_data_penjualan_v2'
CREATE TABLE agg_penjualan_salicyl_v2 AS (
  SELECT 
    id_transaksi, tanggal_transaksi, WEEK(tanggal_transaksi) AS minggu_ke, MONTHNAME(tanggal_transaksi) AS bulan_ke, nama_pelanggan, 
    nama_daerah, jenis_usaha, id_distributor, nama_barang, kategori_produk, satuan_kemasan AS kemasan, jumlah_barang,
    harga_idr, jumlah_barang * harga_idr AS pendapatan
  FROM basis_data_penjualan_v2
  WHERE kategori_produk = 'SLCYL'
);
-- Aggregate table 'agg_semua_penjualan_v2' based on table 'basis_data_penjualan_v2'
CREATE TABLE agg_semua_penjualan_v2 AS (
  SELECT 
    id_transaksi, tanggal_transaksi, WEEK(tanggal_transaksi) AS minggu_ke, MONTHNAME(tanggal_transaksi) AS bulan_ke, nama_pelanggan, 
    nama_daerah, jenis_usaha, id_distributor, nama_barang, kategori_produk, satuan_kemasan AS kemasan, jumlah_barang,
    harga_idr, jumlah_barang * harga_idr AS pendapatan
  FROM basis_data_penjualan_v2
);

## Scenario 3
-- Aggregate table 'agg_penjualan_salicyl_v3' based on table 'basis_data_penjualan_v3'
CREATE TABLE agg_penjualan_salicyl_v3 AS (
  SELECT 
    id_transaksi, tanggal_transaksi, WEEK(tanggal_transaksi) AS minggu_ke, MONTHNAME(tanggal_transaksi) AS bulan_ke, nama_pelanggan, 
    nama_daerah, jenis_usaha, id_distributor, nama_barang, kategori_produk, satuan_kemasan AS kemasan, jumlah_barang,
    harga_idr, jumlah_barang * harga_idr AS pendapatan
  FROM basis_data_penjualan_v3
  WHERE kategori_produk = 'SLCYL'
);
-- Aggregate table 'agg_semua_penjualan_v3' based on table 'basis_data_penjualan_v3'
CREATE TABLE agg_semua_penjualan_v3 AS (
  SELECT 
    id_transaksi, tanggal_transaksi, WEEK(tanggal_transaksi) AS minggu_ke, MONTHNAME(tanggal_transaksi) AS bulan_ke, nama_pelanggan, 
    nama_daerah, jenis_usaha, id_distributor, nama_barang, kategori_produk, satuan_kemasan AS kemasan, jumlah_barang,
    harga_idr, jumlah_barang * harga_idr AS pendapatan
  FROM basis_data_penjualan_v3
);