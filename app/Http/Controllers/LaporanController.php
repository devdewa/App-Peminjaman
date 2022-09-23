<?php

namespace App\Http\Controllers;

use DB;
use Alert;
use App\Exports\LaporanKeluar;
use App\Exports\LaporanMasuk;
use App\Exports\LaporanPeminjaman;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;


class LaporanController extends Controller
{
    public function __construct()
    {
        $this->middleware(['auth','Admin']);
    }

    public function lap_barang_masuk(Request $request)
    {
        $masuk = DB::table("masuk")->whereBetween('tanggal_masuk',[$request->awal,$request->akhir])
            ->join('barangs', function ($join) {
                $join->on('masuk.id_barang', '=', 'barangs.id_barang');
            })->get();

            $hitung=count($masuk);
            $req1=$request->awal;
            $req2=$request->akhir;

        return view('laporan.barang_masuk', compact('masuk','req1','req2','hitung'));
    }

    public function lap_barang_keluar(Request $request)
    {
        
        $keluar = DB::table("keluar")->whereBetween('tanggal_keluar',[$request->awal,$request->akhir])
            ->join('barangs', function ($join) {
                $join->on('keluar.id_barang', '=', 'barangs.id_barang');
            })->get();

        $hitung=count($keluar);
        $req1=$request->awal;
        $req2=$request->akhir;

        return view('laporan.barang_keluar', compact('keluar','hitung','req1','req2'));
    }

    public function lap_peminjaman(Request $request)
    {
        
        $peminjaman = DB::table("peminjaman")
                        ->whereBetween('tanggal_kembali',[$request->awal,$request->akhir])
                        ->where('status',$request->status)
                            ->join('barangs', function ($join) {
                                $join->on('peminjaman.id_barang', '=', 'barangs.id_barang');
                            })
                            ->get();

        $hitung=count($peminjaman);
        $req1=$request->awal;
        $req2=$request->akhir;
        $req3=$request->status;


        return view('laporan.barang_pinjam', compact('peminjaman','hitung','req1','req2','req3'));
    }
    
    public function export_keluar(Request $request)
    {
        $data = DB::table("keluar")->whereBetween('tanggal_keluar',[$request->awal,$request->akhir])
            ->join('barangs', function ($join) {
                $join->on('keluar.id_barang', '=', 'barangs.id_barang');
            })->get();

        return Excel::download(new LaporanKeluar($data), 'lap_keluar.xlsx');
    }

    public function export_masuk(Request $request)
    {
        $data = DB::table("masuk")->whereBetween('tanggal_masuk',[$request->awal,$request->akhir])
            ->join('barangs', function ($join) {
                $join->on('masuk.id_barang', '=', 'barangs.id_barang');
            })->get();

        return Excel::download(new LaporanMasuk($data), 'lap_masuk.xlsx');
    }

    public function export_peminjaman(Request $request)
    {
         $data = DB::table("peminjaman")
                ->whereBetween('tanggal_kembali',[$request->awal,$request->akhir])
                ->where('status',$request->status)
                    ->join('barangs', function ($join) {
                        $join->on('peminjaman.id_barang', '=', 'barangs.id_barang');
                    })->get();

        return Excel::download(new LaporanPeminjaman($data), 'lap_peminjaman.xlsx');
    }

}
