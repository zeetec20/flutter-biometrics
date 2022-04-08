<?php

namespace App\Service;

use App\Repositories\interface\UserRepositoryInterface;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthService
{
    /**
     * @var UserRepositoryInterface
     */
    private $userRepository;

    public function __construct(UserRepositoryInterface $userRepository) {
        $this->userRepository = $userRepository;
    }

    public function profile()
    {
        return Auth::user();
    }

    public function login($email, $password)
    {
        if ($token = Auth::attempt(['email' => $email, 'password' => $password])) return [
            'success' => true,
            'data' => [
                'token' => $token,
                'expire' => auth()->factory()->getTTL() * 60
            ]
        ];
        return [
            'success' => false,
            'message' => 'email or password incorrect'
        ];
    }

    public function register($name, $email, $password)
    {
        if ($this->userRepository->findUserWithEmail($email)->count() == 0) {
            $this->userRepository->create($name, $email, Hash::make($password));
            return [
                'success' => true
            ];
        }
        return [
            'success' => false,
            'message' => 'user already exist'
        ];
    }
}

