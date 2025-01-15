import { NextResponse } from "next/server";

export async function POST() {
  // Clear local storage
  if (typeof window !== "undefined") {
    localStorage.clear();
  }

  // Return a response indicating successful logout
  return NextResponse.json({ success: true });
}
