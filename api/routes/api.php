<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\BiometricsController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('login', [AuthController::class, 'login'])->name('login');
Route::post('register', [AuthController::class, 'register'])->name('register');

Route::middleware('auth.token')->group(function ()
{
    Route::get('profile', [AuthController::class, 'profile'])->name('profile');
    Route::post('biometrics', [BiometricsController::class, 'changeBiometrics'])->name('biometrics');
});
