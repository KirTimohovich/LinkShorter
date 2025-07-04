<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up() // Для формирование БД-шки
    {
        Schema::create('links', function (Blueprint $table) {
            $table->id();
            $table->string('original_url');
            $table->string('short_url', 6)->unique();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->integer('clicks')->default(0); // Счетчик переходов
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('links');
    }
};
