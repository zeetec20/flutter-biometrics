<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class LoginTest extends TestCase
{
    use RefreshDatabase;

    public function test_success_login()
    {
        $user = User::factory()->create();
        $response = $this->post(route('login'), [
            'email' => $user->email,
            'password' => 'admin123'
        ]);
        $response->assertStatus(200);
        $this->assertTrue($response->json()['success']);
        $this->assertArrayHasKey('token', $response->json()['data']);
    }

    public function test_failed_without_body()
    {
        $response = $this->post(route('login'));
        $response->assertStatus(400);
        $this->assertFalse($response->json()['success']);
        $this->assertArrayHasKey('success', $response->json());
        $this->assertArrayHasKey('message', $response->json());
        $this->assertArrayHasKey('data', $response->json());
    }
}
