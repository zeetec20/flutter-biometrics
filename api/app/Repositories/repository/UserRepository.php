<?php

namespace App\Repositories\repository;

use App\Models\User;
use App\Repositories\interface\UserRepositoryInterface;
use Illuminate\Support\Facades\Hash;

class UserRepository implements UserRepositoryInterface
{
    /**
     * @var User
     */
    private $model;

    public function __construct(User $user) {
        $this->model = $user;
    }

    public function create($name, $email, $password)
    {
        return $this->model->create([
            'name' => $name,
            'email' => $email,
            'password' => $password
        ]);
    }

    public function findUserWithEmail($email)
    {
        return $this->model->where('email', $email)->get();
    }

    public function findUserWithId($id)
    {
        return $this->model->where('id', $id)->get();
    }

    public function updateBiometrics($id, $use)
    {
        $user = $this->model->where('id', $id)->first();
        $user->use_biometrics = $use;
        $user->save();
        return $user;
    }
}
