## Scenario 1
## Create a base table, named 'all_sales_data,' to combine all necessary information related to sales data by
## joining the sales table 'penjualan' with the two dimension tables 'pelanggan' and 'barang'.
## The purpose of this step is to provide completed sales data (data penjualan), so
## when there is a need to perform analysis or aggregation of the data, we don't need to use 
## multiple tables with join functions anymore.
-- Create table 'basis_data_penjualan'
CREATE TABLE basis_data_penjualan AS (
	SELECT
		pj.id_transaksi, pj.tanggal_transaksi, pj.id_pelanggan, pl.nama_pelanggan, pj.id_distributor, 
        pj.id_cabang, pl.nama_daerah, pl.jenis_usaha, pj.id_barang, br.nama_barang, pj.id_merek, 
        pj.kategori_produk, br.tipe_produk, pj.satuan_kemasan, pj.jumlah_barang, pj.harga_idr
	FROM penjualan AS pj
		LEFT JOIN pelanggan AS pl ON pj.id_pelanggan = pl.id_pelanggan
        LEFT JOIN barang AS br ON pj.id_barang = br.id_barang
);
## Scenario 2
## The scenario where only table 'penjualan2' is accurate because every 'id_transaksi' can be associated with multiple items
## or 'id_barang'. This is more natural or believable because it is impossible for every transaction to only purchase one kind of item.
## However, the time range is too short as the period between the earliest and latest purchases in table 'penjualan2' is only 14 days.
-- Create table 'basis_data_penjualan_v2' 
CREATE TABLE basis_data_penjualan_v2 AS (
	SELECT
		pj.id_transaksi, pj.tanggal_transaksi, pj.id_pelanggan, pl.nama_pelanggan, pj.id_distributor, 
        pj.id_cabang, pl.nama_daerah, pl.jenis_usaha, pj.id_barang, br.nama_barang, pj.id_merek, 
        pj.kategori_produk, br.tipe_produk, pj.satuan_kemasan, pj.jumlah_barang, pj.harga_idr
	FROM penjualan2 AS pj
		LEFT JOIN pelanggan AS pl ON pj.id_pelanggan = pl.id_pelanggan
        LEFT JOIN barang AS br ON pj.id_barang = br.id_barang
);
## Scenario 3
## The scenario where only table 'penjualan1' is accurate, and every purchase or 'id_transaksi' can only be associated with one item
## or 'id_barang'. This is very unlikely. However, since we don't know if the available data is legitimate or not, it's not harmful to
## consider every possible scenario. Even though the data is very unlikely to be legitimate, it is useful for analyzing the sales trend
## because it has a broader time frame range of 5 months.
-- Create table 'basis_data_penjualan_v3' 
CREATE TABLE basis_data_penjualan_v3 AS (
	SELECT
		pj.id_transaksi, pj.tanggal_transaksi, pj.id_pelanggan, pl.nama_pelanggan, pj.id_distributor, 
        pj.id_cabang, pl.nama_daerah, pl.jenis_usaha, pj.id_barang, br.nama_barang, pj.id_merek, 
        pj.kategori_produk, br.tipe_produk, pj.satuan_kemasan, pj.jumlah_barang, pj.harga_idr
	FROM penjualan1 AS pj
		LEFT JOIN pelanggan AS pl ON pj.id_pelanggan = pl.id_pelanggan
        LEFT JOIN barang AS br ON pj.id_barang = br.id_barang
);