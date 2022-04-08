<?php

namespace App\Service;

use App\Repositories\interface\UserRepositoryInterface;
use Illuminate\Support\Facades\Auth;

class BiometricsService
{
    /**
     * @var UserRepositoryInterface
     */
    private $userRepository;

    public function __construct(UserRepositoryInterface $userRepository) {
        $this->userRepository = $userRepository;
    }

    public function changeBiometrics()
    {
        $user = Auth::user();
        $user = $this->userRepository->updateBiometrics($user->id, !$user->use_biometrics);
        return [
            'success' => true,
            'message' => 'biometrics is '. ($user->use_biometrics ? 'active' : 'deactive')
        ];
    }
}
