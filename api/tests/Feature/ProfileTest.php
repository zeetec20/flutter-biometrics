<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class ProfileTest extends TestCase
{
    use RefreshDatabase;

    public function test_failed_without_token()
    {
        $response = $this->get(route('profile'));
        $response->assertStatus(401);
    }

    public function test_success_profile()
    {
        $user = User::factory()->create();
        $responseLogin = $this->post(route('login'), [
            'email' => $user->email,
            'password' => 'admin123'
        ]);
        $response = $this->get(route('profile'), [
            'Authorization' => 'Bearer '.$responseLogin->json()['data']['token']
        ]);
        $response->assertStatus(200);
        $response->assertJson($user->toArray());
    }
}
