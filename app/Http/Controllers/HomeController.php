<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use Carbon\Carbon;
use Auth;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {
        if (Auth::user()->level=='admin') {
            $barang2 = DB::table('barangs')->get();

        $hitung_barang=count($barang2);

        $masuk2 = DB::table("masuk")
            ->join('barangs', function ($join) {
                $join->on('masuk.id_barang', '=', 'barangs.id_barang');
            })->get();
        $hitung_masuk=count($masuk2);

        $keluar2 = DB::table("keluar")
            ->join('barangs', function ($join) {
                $join->on('keluar.id_barang', '=', 'barangs.id_barang');
            })->get();
        
        $hitung_keluar=count($keluar2);

        $peminjaman = DB::table("peminjaman")
            ->join('barangs', function ($join) {
            $join->on('peminjaman.id_barang', '=', 'barangs.id_barang');
            })->get();
        
        $hitung_pinjam=count($peminjaman);


        return view('user.home',compact('hitung_barang','hitung_masuk','hitung_keluar','hitung_pinjam'));
        }else{
            return view('pembimbing.dashboard_pem');
        }
    }

    public function update_siswa(Request $request)
    {
        
    }
}
