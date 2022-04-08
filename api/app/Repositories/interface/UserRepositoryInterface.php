<?php

namespace App\Repositories\interface;

use App\Models\User;
use Illuminate\Database\Eloquent\Collection;

interface UserRepositoryInterface {
    /**
     * @param string $id
     *
     * @return Collection
     */
    public function findUserWithId($id);

    /**
     * @param string $email
     */
    public function findUserWithEmail($email);

    /**
     * @param int $id
     * @param boolean $use
     *
     * @return User
     */
    public function updateBiometrics($id, $use);

    /**
     * @param string $name
     * @param string $email
     * @param string $password
     *
     * @return User
     */
    public function create($name, $email, $password);
}
