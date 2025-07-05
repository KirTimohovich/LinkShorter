<?php

namespace App\Http\Controllers;

use App\Models\Link;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Auth;

class LinkController extends Controller
{
    public function index()
    {
        return view('welcome');
    }

    public function create(Request $request)
    {
        $request->validate(['url' => 'required|url']);

        $shortUrl = Str::random(6);

        Link::create([
            'original_url' => $request->url,
            'short_url' => $shortUrl,
            'user_id' => Auth::id(),
        ]);

        return response()->json(['shortUrl' => url('/' . $shortUrl)]);
    }

    public function redirect($shortUrl)
    {
        $link = Link::where('short_url', $shortUrl)->firstOrFail();
        $link->increment('clicks');
        return redirect($link->original_url);
    }

    public function indexLinks()
    {
        $links = Auth::user()->links()->get();
        return response()->json($links);
    }

    public function clearLinks()
    {
        Auth::user()->links()->delete();
        return response()->json(['success' => true]);
    }
}
