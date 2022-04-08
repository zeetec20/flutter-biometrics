<?php

namespace App\Http\Controllers;

use App\Http\Requests\LoginRequest;
use App\Http\Requests\RegisterRequest;
use Illuminate\Http\Request;
use App\Service\AuthService;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    private $authService;

    public function __construct(AuthService $authService) {
        $this->authService = $authService;
    }

    public function login(LoginRequest $request)
    {
        $data = $request->all(['email', 'password']);
        return response()->json($this->authService->login($data['email'], $data['password']));
    }

    public function register(RegisterRequest $request)
    {
        $data = $request->all(['name', 'email', 'password']);
        return response()->json($this->authService->register($data['name'], $data['email'], $data['password']));
    }

    public function profile(Request $request)
    {
        return response()->json($this->authService->profile());
    }
}
