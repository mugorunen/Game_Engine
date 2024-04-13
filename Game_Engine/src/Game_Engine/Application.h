#pragma once

#include "Core.h"

namespace Game_Engine{
	class GE_API Application {
	public:
		Application();
		virtual ~Application();

		void Run();

	};

	Application* CreateApplication();

	
}


