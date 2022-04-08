<?php

namespace App\Http\Controllers;

use App\Service\BiometricsService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class BiometricsController extends Controller
{
    /**
     * @var BiometricsService
     */
    private $biometricsService;

    public function __construct(BiometricsService $biometricsService) {
        $this->biometricsService = $biometricsService;
    }

    public function changeBiometrics(Request $request)
    {
        return response()->json($this->biometricsService->changeBiometrics());
    }
}
