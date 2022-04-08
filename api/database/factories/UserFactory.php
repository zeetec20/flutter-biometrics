<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;


class UserFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'name' => $this->faker->name(),
            'email' => $this->faker->unique()->safeEmail(),
            'password' => '$2y$10$L4dub/w5f.A5R5KtGBjuOOZ5ImNR0TmPQJQsrv.F9N9BGBADo4uoi'
        ];
    }
}
