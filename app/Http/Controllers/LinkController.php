<?php

namespace App\Http\Controllers;

use App\Models\Link;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class LinkController extends Controller
{
    public function index()
    {
        return view('index'); // Главная с отображением формы сокращения ссылок
    }

    public function create(Request $request) // Создает короткую ссылку
    {
        $request->validate(['url' => 'required|url']);

        $shortUrl = Str::random(6);

        Link::create([
            'original_url' => $request->url,
            'short_url' => $shortUrl,
        ]);

        return response()->json(['shortUrl' => url('/' . $shortUrl)]);
    }

    public function redirect($shortUrl)
    {
        $link = Link::where('short_url', $shortUrl)->firstOrFail();
        return redirect($link->original_url);
    }
    public function indexLinks()
    {
        $links = Link::all(); // Получаю все ссылки из бдшки
        return response()->json($links); // Возвращаются ссылки в формате JSON
    }
    public function clearLinks()
    {
        try {
            Link::truncate(); // Очистить всю таблицу links (Нету деления на юзеров, чистится вся таблица)
            return response()->json(['success' => true]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'error' => $e->getMessage()], 500);
        }
    }
}
