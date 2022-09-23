<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Redirect,Response,DB,Config;
use Datatables;
use Auth;
class DatatableController extends Controller
{
  
  
    public function barang_json()
    {
         $barang = DB::table('barangs')
            ->join('kategori', function ($join) {
                $join->on('barangs.kategori_id', '=', 'kategori.id_kategori');
            })->get();


        return datatables()->of($barang)
        ->addColumn('action', function ($u) {
            return '<a href="/barang/edit/'.$u->id_barang.'" class="btn btn-primary btn-sm ml-2"">Edit </a>
           <a href="/barang/qrcode/'.$u->id_barang.'" class="btn btn-warning btn-sm ml-2"">QR Code </a>
            ';
        })
        ->addColumn('total', function ($u) {
            return $u->jumlah + $u->jumlah_rusak;
        })
        ->make(true);
        
        return datatables()->of($barang)->make(true);
    }

    public function keluar_json()
    {
      $keluar = DB::table("keluar")
            ->join('barangs', function ($join) {
                $join->on('keluar.id_barang', '=', 'barangs.id_barang');
            })->get();

              return datatables()->of($keluar)
        ->addColumn('action', function ($u) {
            return '<a href="/keluar/edit/'.$u->id_keluar.'" class="btn btn-primary btn-sm ml-2"">Edit </a>
            ';
        })
        ->make(true);

        return datatables()->of($keluar)->make(true);
    }
     public function masuk_json()
    {
        $masuk = DB::table("masuk")
            ->join('barangs', function ($join) {
                $join->on('masuk.id_barang', '=', 'barangs.id_barang');
            })->get();

        return datatables()->of($masuk)
        ->addColumn('action', function ($u) {
            return '<a href="/masuk/edit/'.$u->id_masuk.'" class="btn btn-primary btn-sm ml-2"">Edit </a>
            <a href="/masuk/detail/'.$u->id_masuk.'" class="btn btn-warning btn-sm ml-2"">Detail </a>
            
            ';
        })
        ->make(true);

        return datatables()->of($masuk)->make(true);
    }


    public function peminjaman_json()
    {
       
     $peminjaman = DB::table("peminjaman")
            ->join('barangs', function ($join) {
                $join->on('peminjaman.id_barang', '=', 'barangs.id_barang');
            })->get();

        return datatables()->of($peminjaman)
        ->addColumn('action', function ($u) {
            if ($u->status=='Belum Dikembalikan') {
                return '<a href="/peminjaman/edit/'.$u->id_peminjaman.'" class="btn btn-primary btn-sm ml-2"">Edit </a>
                <a href="/peminjaman/detail/'.$u->id_peminjaman.'" class="btn btn-warning btn-sm ml-2"">Detail </a>
                <a href="/peminjaman/status/'.$u->id_peminjaman.'/'.$u->id_barang.'" class="btn btn-success btn-sm ml-2"  onclick="return confirm("Apakah Anda Yakin ?")">Kembalikan </a>
                
            ';
            }else{
                 return '<a href="/peminjaman/detail/'.$u->id_peminjaman.'" class="btn btn-warning btn-sm ml-2"">Detail </a>
            ';
            }
        })
        ->make(true);

        return datatables()->of($peminjaman)->make(true);
    }


}
